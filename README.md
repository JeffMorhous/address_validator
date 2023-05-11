# Empora Code Sample

This is a command-line program that validates a US address against an API
and outputs either the corrected address or `Invalid Address`

## How to Run My Code

First, install dependencies:

```bash
bundle install
```

Next, set environment variables, `AUTH_ID`, `AUTH_TOKEN`, and `LICENSE`:

```bash
export AUTH_ID=<your_auth_id>
export AUTH_ID=<your_auth_token>
export LICENSE=<your_chosen_license>
```

Note, for license, I used `us-core-cloud`

Then, you can run the code with:

```bash
ruby validate.rb <path-to-file>
```

I've included a test csv file with the provided data, you can run against it with:

```bash
ruby validate.rb spec/fixtures/test_file.csv
```

## How to Run My Unit Tests

After you've installed dependencies with:

```bash
bundle install
```

You can run the unit tests with:

```bash
bundle exec rspec
```

## My Thought Process

My focus here was to create logically different components with separated concerns. This lead me
to 3 main classes:

- CLI
- AddressValidator 
- CSVFileReader

There is a validate.rb script that actually is executed from the command line, which parses the filepath
from `ARGV`, then passes it to the CLI class.

The `CLI` class has a `run` method that leverages the other two classes to parse data and correct it, then
outputs the formatted data to the console.

The `CSVFileReader` class takes in a filepath, and uses the Ruby csv gem to parse the file into a hash,
while tranforming the keys so that they can be easily sent to the api with proper names.

The `AddressValidator` class takes an entire array of properly formatted Addresses, and hits the provided
API for validating them. This was the most complicated class to write. Originally, I was sending one address
at a time, but when I discovered I could POST to the same endpoint with mutliple addresses, I decided
to do that to save on API calls. This does limit the number of addresses to 100, and given the provided
test data, I decided that would be a fair tradeoff.
