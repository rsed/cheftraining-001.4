maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures splunk"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "rightscale"

recipe "splunk::install", "Installs splunk from a tar file. Uses attributes and definitions"

attribute "splunk/user",
:display_name => "Splunk User",
:description => "The name of the Splunk user",
:recipes => ["splunk::install"],
:required => "required"

