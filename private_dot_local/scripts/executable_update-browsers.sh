#!/usr/bin/env bash

apt update

apt upgrade firefox -y

if [ $? -eq 0 ]; then
    notify-send 'Firefox updated successfully.'

apt upgrade brave-browser -y

if [ $? -eq 0 ]; then
    notify-send 'Brave updated successfully.'

apt upgrade librewolf -y

if [ $? -eq 0 ]; then
    notify-send 'Librewolf updated successfully.'
