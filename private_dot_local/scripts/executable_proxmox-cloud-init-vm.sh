#!/usr/bin/env bash

VMID="9000"
STORAGE="local-lvm"
VMNAME="ubuntu-2404-$(date +%Y%m%d)"
IMAGE="noble-server-cloudimg-amd64.img"
IMAGEURL="https://cloud-images.ubuntu.com/noble/current/$IMAGE"

if [[ ! -f ./"$IMAGE" ]]; then
    wget -O "$IMAGE" "$IMAGEURL"
fi

qm create "$VMID" --memory 2048 --cores 2 --name "$VMNAME" --net0 virtio,bridge=vmbr0
qm importdisk "$VMID" "$IMAGE" "$STORAGE"
qm set "$VMID" --bios ovmf
qm set "$VMID" --efidisk0 "$STORAGE":1,format=raw,pre-enrolled-keys=0
qm set "$VMID" --scsihw virtio-scsi-pci --scsi0 "$STORAGE":vm-"$VMID"-disk-0
qm set "$VMID" --ide2 "$STORAGE":cloudinit
qm set "$VMID" --boot c --bootdisk scsi0
qm set "$VMID" --serial0 socket --vga serial0
qm resize "$VMID" scsi0 +10G
qm template "$VMID"
