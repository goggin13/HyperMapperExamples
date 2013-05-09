rm -rf ~/data/daemon_dir
mkdir ~/data/daemon_dir
rm -rf ~/data/daemon_data
mkdir ~/data/daemon_data

cd ~/data/daemon_dir
hyperdex daemon -f --listen=127.0.0.1 \
                   --listen-port=2012 \
                   --coordinator=127.0.0.1 \
                   --coordinator-port=1982 \
                   --data=/home/ubuntu/data/daemon_data \
		   --daemon

