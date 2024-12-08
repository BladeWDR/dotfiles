#!/usr/bin/env bash
# Sanoid installation helper script.

set -eou pipefail

if [[ ! -d "$PWD/sanoid" ]]; then
    # Download the repo as root to avoid changing permissions later
    sudo git clone https://github.com/jimsalterjrs/sanoid.git
fi

cd sanoid

# checkout latest stable release or stay on master for bleeding edge stuff (but expect bugs!)
git checkout $(git tag | grep "^v" | tail -n 1)

# Install the executables
sudo cp sanoid syncoid findoid sleepymutex /usr/local/sbin

# Create the config directory
sudo mkdir -p /etc/sanoid

# Install default config
sudo cp sanoid.defaults.conf /etc/sanoid

if [[ ! -f /etc/sanoid/sanoid.conf ]]; then

    # Create a blank config file
    sudo touch /etc/sanoid/sanoid.conf

    # Place the sample config in the conf directory for reference
    sudo cp sanoid.conf /etc/sanoid/sanoid.example.conf
fi

# Create a systemd unit

cat << "EOF" | sudo tee /etc/systemd/system/sanoid.service
[Unit]
Description=Snapshot ZFS Pool
Requires=zfs.target
After=zfs.target
Wants=sanoid-prune.service
Before=sanoid-prune.service
ConditionFileNotEmpty=/etc/sanoid/sanoid.conf

[Service]
Environment=TZ=UTC
Type=oneshot
ExecStart=/usr/local/sbin/sanoid --take-snapshots --verbose
EOF

cat << "EOF" | sudo tee /etc/systemd/system/sanoid-prune.service
[Unit]
Description=Cleanup ZFS Pool
Requires=zfs.target
After=zfs.target sanoid.service
ConditionFileNotEmpty=/etc/sanoid/sanoid.conf

[Service]
Environment=TZ=UTC
Type=oneshot
ExecStart=/usr/local/sbin/sanoid --prune-snapshots --verbose

[Install]
WantedBy=sanoid.service
EOF

# Create systemd timer
cat << "EOF" | sudo tee /etc/systemd/system/sanoid.timer
[Unit]
Description=Run Sanoid Every 15 Minutes
Requires=sanoid.service

[Timer]
OnCalendar=*:0/15
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable sanoid-prune.service
sudo systemctl enable --now sanoid.timer
