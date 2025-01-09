#!/usr/bin/env bash

# This script was written to work with WSL2. I have not tested it anywhere else.

set -eou pipefail

input="$1"

html_content=$(pandoc -f markdown-auto_identifiers+wikilinks_title_after_pipe -t html "$input")

email_subject=$(echo "$html_content" | sed -n 's|<h1[^>]*>\(.*\)</h1>|\1|p' | head -1)

echo "Subject is $email_subject"

# Send email using Outlook via PowerShell in WSL2
powershell.exe -Command "
\$Outlook = New-Object -ComObject Outlook.Application
\$Mail = \$Outlook.CreateItem(0)
\$Mail.Subject = '${email_subject}'
\$Mail.HTMLBody = @'
$html_content
'@
\$Mail.Display()
"
