# hello-world-docker-action
This is a research project to help me become more familiar with Github Actions.

The goal is to learn enough here to get ScienceOven's GitHub actions up to snuff.

This project is really a throwaway/experiment. I don't see a lot of details on how to test against a database after a push. I've learned what I've learned, and now I'm going to apply
what I've learned. I expect to have a lot of failed experiments, which is the main reason
that I'm doing this in a project other than ScienceOven.


I started by following this [tutorial](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action).

Once I got the simplistic tutorial work8hg, I started experimenting with how to get the following functionality working:
- SQL Server running (via Docker)
- Pester working
- Query the SQL Server via Invoke-SqlCmd2
- Query the SQL Server via DbaTools



The following is the suggested content from the the tutorial.

# Hello world docker action

This action prints "Hello World" or "Hello" + the name of a person to greet to the log.

## Inputs

## `who-to-greet`

**Required** The name of the person to greet. Default `"World"`.

## Outputs

## `time`

The time we greeted you.

## Example usage

uses: actions/hello-world-docker-action@v1
with:
  who-to-greet: 'Mona the Octocat'