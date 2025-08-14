#!/usr/bin/env bash

# This script was written to work with WSL2. I have not tested it anywhere else.
# It's often convenient for me to be able to quickly convert markdown (which is much easier to write than HTML) into HTML content
# This is just a convenience wrapper script I made so I don't need to remember all the pandoc options

set -eou pipefail

send_outlook=false

# Function to send an email using Outlook via PowerShell in WSL2
Outlook(){
    # Base64 encode the HTML content to avoid issues with special characters
    html_content_base64=$(echo -n "$html_content" | base64 -w 0)

    powershell.exe -Command "
    \$Outlook = New-Object -ComObject Outlook.Application
    \$Mail = \$Outlook.CreateItem(0)
    \$Mail.Subject = '${email_subject}'
    \$Mail.HTMLBody = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('${html_content_base64}'))
    \$Mail.Display()
    "
}

while getopts ":o" arg; do
    case "$arg" in
        o) send_outlook=true ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done

# Shift past options and get the filename (last argument)
shift $((OPTIND-1))

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [-o] <filename>"
    exit 1
fi

input="$1"
html_content=$(pandoc -f markdown-auto_identifiers+wikilinks_title_after_pipe-smart -t html "$input")

if [[ "$send_outlook" == true ]]; then
    email_subject=$(echo "$html_content" | sed -n 's|<h1[^>]*>\(.*\)</h1>|\1|p' | head -1)
    Outlook
else
    echo "$html_content"
fi
