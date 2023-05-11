# Empora Code Sample

This is a command-line program that validates a US address against an API
and outputs either the corrected address or `Invalid Address`

## Overview

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
ruby validate.rb fake_data/test_data_1.csv
```

## How to Run My Unit Tests

## My Thought Process
