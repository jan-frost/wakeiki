---
title:  "Starting My AI-Assisted Programming Journey"
date:   2024-10-07 21:00:00 +0200
categories: development
---

Today marks the beginning of an exciting adventure into the world of Elm and Android development, guided by AI assistance. I've set up this blog to document my progress, share insights, and reflect on the learning process.

> Ok, let's stop here. That's not really what I want to do. I am trying to see if I can set up a whole project with AI assistance. I actually instructed the IDE I am using (https://www.cursor.com) to comment anything I am asking it to do. What you see here is more or less the raw output of that. I will meta-comment it in these blocks.
>
> The project is inspired by the excellent talk "AI-powered software development from the trenches" by Henrik Kniberg I was fortunate enough to see at goto; Copenhagen 2024. There is an older version of the talk available on Youtube: [https://youtu.be/3eaNZPW2JH8?si=r-0thizN7pRxoBvE](https://youtu.be/3eaNZPW2JH8?si=r-0thizN7pRxoBvE).

## Project Goals

Our main objective is to develop an Android app using the Elm programming language. We're embracing several key principles:

1. Test-Driven Development (TDD)
2. Testing Without Mocks
3. Accessibility from the start
4. Internationalization and localization
5. Security best practices

> Don't want to make it easy in the AI. I want it to create quality code based on some explicit design choices (that may actually be a little non-mainstream in some cases).
>
> This is more or less what I am giving it as context:
>> Design
>> - written in the Elm programming language
>> - published as an Android app
>> - using the Testing Without Mocks pattern, most importantly
>>   - no mocking of any kind, use nullable infrastructure wrappers instead
>>   - sociable state-based unit tests
>> - unidirectional data flow
>> - implement accessibility features from the start
>> - design for internationalization (i18n) and localization (l10n)
>> - follow security best practices throughout development
>> - document any additional decisions as Architecture Decision Records (ADR)
>> 
>> Test-driven development: for each feature
>> - first compose a list of test cases
>> - for each test case, one by one
>>   - write a failing unit test
>>   - make the test pass
>>   - propose refactoring steps
>> - add an acceptance test
>>   - write a feature specification in gherkin notation
>>   - generate test steps
>> - add security-focused tests
>> 
>> Infrastructure
>> - this project should be hosted on GitHub
>> - add scripts and configuration files to automate the build, test and release process
>> - implement secure coding practices and regular security audits
>> - no pull requests, I want to directly commit to the main branch
>> - use semantic versioning, tag commits with version numbers
>> 
>> I don't know Elm and Android development. Teach me as we go along.
>> 
>> I want to write a blog post based on everything I do here
>> - the blog should be written using Jekyll
>> - the blog should be hosted on GitHub Pages
>> Add blog post drafts for all my actions. The reader should know that I am using AI assistance, so feel free to add the prompts and discuss the outcomes.
>> 
>> Don't give me completions in markdown blockquotes.
>
> That last one doesn't work yet. Constantly getting suggestions as you type is really irritating. Will figure that one out later.

## Setting Up the Blog

The first step in this journey was setting up this very blog! We're using Jekyll, a static site generator, and hosting it on GitHub Pages. This setup allows for easy updates and version control of our blog posts alongside our project code.

Stay tuned for more updates as we dive deeper into Elm, Android development, and the intricacies of our project!

## Overcoming Setup Challenges: A Lesson in Troubleshooting

Today, we encountered our first technical hurdle in setting up our development blog. While trying to install Jekyll, we ran into issues with native extensions on Windows.

This experience highlighted an important aspect of software development: things don't always go smoothly, and troubleshooting is a crucial skill. We explored several potential solutions:

1. Updating Ruby to the latest version
2. Installing the Ruby Development Kit
3. Manually installing problematic dependencies
4. Considering alternative static site generators like Hugo

These challenges, while frustrating, provide valuable learning opportunities. They push us to deepen our understanding of our development environment and broaden our problem-solving skills.

Whether we end up successfully installing Jekyll or pivoting to an alternative like Hugo, this experience has already provided a taste of the problem-solving journey we're embarking on. Stay tuned to see how we resolve this and move forward with our blog setup!

> That did work pretty well. I just gave Cursor the error message and the first thing it told me to do - install the Ruby development kit - fixed the issues. Also, I needed to run the installation as admin (I'm on Windows 11).
>
> It could have told me so in the first place, though. The instructions on how to set up Jekyll just said "make sure you have Ruby installed".