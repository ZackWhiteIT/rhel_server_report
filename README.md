# RHEL Server Report

_Reconnaissance against a server_

## About

RHEL Server Report is a simple bash script, providing server configuration, web server, and database details. Use this tool when logging onto a server to get a _lay of the land_ or compare server configurations.

## Install

Download the RHEL_server_report directory to your machine or server.

_If copying from a Windows machine to a RHEL server, use a FTP utility, such as [WinSCP](https://winscp.net/eng/index.php)._

###### Dependencies

[lshw](https://github.com/lyonel/lshw)

`yum install lshw`

## Usage

_Tip: Run as sudo_

`sudo sh server_report.sh > server_report.txt 2>server_report.err`

This generates a TXT report and logs errors to an ERR file.

## Version

0.0.3
2018-06-13

Review change history in the [changelog](CHANGELOG.md)

## License

[MIT License](LICENSE)
