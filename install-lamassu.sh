#!/usr/bin/env bash
set -e

HOME=~lamassu
CERT_DIR=$HOME/certs
CONFIG_DIR=$HOME/.lamassu

mkdir -p $CERT_DIR >> $LOG_FILE 2>&1
mkdir -p $CONFIG_DIR >> $LOG_FILE 2>&1

export BIN=$(npm bin)
echo "export PATH=\$PATH:$BIN" >> $HOME/.bashrc

echo "Installing lamassu-server..."
npm install bunyan pm2 migrate lamassu/lamassu-server#two-way-db-changes \
  lamassu/lamassu-admin lamassu/lamassu-scripts >> $LOG_FILE 2>&1
$BIN/pm2 install pm2-logrotate >> $LOG_FILE 2>&1

echo "Generating SSL certificates..."
openssl req -new -newkey rsa:4096 -days 9999 -nodes -x509 -subj "/C=US/ST=/L=/O=/CN=$IP:8081" -keyout $CERT_DIR/lamassu-admin.key  -out $CERT_DIR/lamassu-admin.crt >> $LOG_FILE 2>&1
openssl req -new -newkey rsa:4096 -days 9999 -nodes -x509 -subj "/C=US/ST=/L=/O=/CN=$IP:3000" -keyout $CERT_DIR/lamassu-server.key -out $CERT_DIR/lamassu-server.crt >> $LOG_FILE 2>&1

cat <<EOF > $CONFIG_DIR/lamassu.json
{
  "postgresql": "postgres://lamassu_pg:$POSTGRES_PW@localhost/lamassu",
  "certPath": "$CERT_DIR/lamassu-server.crt",
  "certKeyPath": "$CERT_DIR/lamassu-server.key",
  "seedPath": "$SEED_FILE"
}
EOF

cat <<EOF > $CONFIG_DIR/lamassu-admin.json
{
  "certPath": "$CERT_DIR/lamassu-admin.crt",
  "certKeyPath": "$CERT_DIR/lamassu-admin.key"
}
EOF

NPM_ROOT=$(npm root)
$BIN/migrate -c $NPM_ROOT/lamassu-server >> $LOG_FILE 2>&1

echo "Installing lamassu-admin..."
ADMIN_PW=$($BIN/hkdf lamassu-admin-pw $SEED)
$BIN/lamassu-useradd admin $ADMIN_PW >> $LOG_FILE 2>&1

echo "Starting lamassu-admin..."
$BIN/pm2 start $BIN/lamassu-admin --env '{"NODE_ENV": "production"}' >> $LOG_FILE 2>&1
$BIN/pm2 start $BIN/lamassu-server --env '{"NODE_ENV": "production", "LAMASSU_ENV": "debug"}' --restart-delay 10000 >> $LOG_FILE 2>&1
$BIN/pm2 save >> $LOG_FILE 2>&1

echo
echo "Done! Now it's time to configure Lamassu stack."
echo "Open https://$IP:8081 in your browser to access "
echo "your admin panel."
echo
echo "Default login info for lamassu-admin:"
echo "User: admin / Password: $ADMIN_PW"
echo
echo "Please write this down in a safe place."
echo -e "\n*** IMPORTANT ***"
echo "Backup the contents of $SEED_FILE in a safe place."
echo "This seed will allow you to retrieve system passwords, including "
echo "the keys to your Ethereum accounts."
echo
