# hello-world-docker-action
This is a research project to help me become more familiar with Github Actions

I am following this tutorial:
https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action

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