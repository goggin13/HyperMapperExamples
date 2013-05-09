rm -rf ~/data/coordinator_dir
mkdir ~/data/coordinator_dir
cd ~/data/coordinator_dir
hyperdex coordinator -f -l 127.0.0.1 -p 1982 --daemon

