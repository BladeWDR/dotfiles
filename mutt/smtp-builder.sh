#!/usr/bin/env bash
# Writing these by hand is a pain in the butt, but I don't want to store this information on Github.
# Lets automate the annoying bits.

read -p "Enter your full name: " fullname
read -p "Enter your email address: " emailaddress
read -p "Enter your SMTP server URL: " smtpserver
read -p "Enter your SMTP port number (usually 456 or 587):" port
read -p "Enter the path to the password in your pass vault: " passpath
read -p "Enter the filename you'd like to use: " filename

# Write the configuration file
echo 'set my_smtp_pass = `pass show '"$passpath"'`' | tee -a "$filename"
echo "set from = \"$fullname <$emailaddress>\"" | tee -a "$filename"
echo "set smtp_url = \"smtps://$emailaddress:\$my_smtp_pass@$smtpserver:$port\"" | tee -a "$filename"
