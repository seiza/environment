#!/bin/bash
source env.sh
ETHERBASE=$DATA_DIR/etherbase.txt

echo "Initialisation network $NETWORK_DIR"
if [ -d $DATA_DIR ]; then
  rm -rf $DATA_DIR
fi

/geth --datadir $DATA_DIR init ./gethGenesisBlock.json

cat <<EOF >$DATA_DIR/static-nodes.json
[
    "enode://32571cbf29863ecde4ee89e49d8c88cd4baec13ef5937c54cf06403ecf9e45869c439546ef3d2eb5391b8c42541430c2025b8269ad86fdd56607cbf905afc1bb@195.154.221.20:10000"
]
EOF


echo "Creating an etherbase for mining"
echo -e "password" > $ETHERBASE
/geth --datadir $DATA_DIR --password $ETHERBASE account new

chmod +x ./gethStartNode.sh

echo "Setting up eth net intelligence api"
wget http://github.com/cubedro/eth-net-intelligence-api/archive/master.zip
unzip master.zip
cd eth-net-intelligence-api-master
npm install