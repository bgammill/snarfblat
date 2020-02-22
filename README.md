# snarfblat
A shell script to send notifications via Pushover

## Installation
```
git clone https://github.com/bgammill/snarfblat && cd $_

sudo mv snarfblat.sh /usr/local/bin

sudo chmod +x /usr/local/bin/snarfblat.sh
```

## Configuration
You can either use command line arguments, or create ~/.snarfblat.conf with the contents below, replacing the values with your application-specific configuration.
```
SNARFBLAT_TOKEN="token_here"
SNARFBLAT_USER="user_here"
```

## Usage
### Arguments
```
Usage: snarfblat.sh -m=message [options]

Short Options:			Full Options:
-m="hello, world!"		--message="hello, world!"
-t="this is a test"		--title="this is a test"
-o=123456789			--token="123456789"
-u=123456789			--user="123456789"
```
### Input
`snarfblat.sh --message="hello from snarfblat!"`

### Output
`{"status":1,"request":"6df85dc4-96fa-8271-ad71-7b94a0aea57b"}`
