# R Data Project - Documentation & Coding Standards

## Documentation
Alongside each of the spikes, there will be a markdown file that displays basic information on what is expected of each user.

### Markdown Resources
 - [MarkDown Editor](https://dillinger.io/)
 - [Print MarkDown](https://gitprint.com/)
 - [Markdown Cheat Sheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)


## Coding Standards
 - We have adopted [Google's R style guide](https://google.github.io/styleguide/Rguide.xml) as our set of standards for formatting R code.

Below are some main points of the style guide:
 - File names ends with a ".R"
 - 2 spaces are used for indentation
 - Use <- exclusively as the assignment operator
 - Disallow the use of semicolons
 - When naming items, using.dots.to.separate.words is the preferred method. CamelCase is also acceptable. Undersocres and hyphens are disallowed.
 - FunctionNames have an initial capital letter and contains no dots
 - Lines have a maximum of 80 characters
 - Binary operators such as +, -, /, and \* have a space on each side
 	- Space around the assignment operators such as = is optional
 - Functions must first list arguments that don't have a default value
 - Avoid calling the attatch() function

### Blocks 
 - Else statements are surrounded by curly braces
 - The opening curly brace cannot be in a line of it's own. Also, the closing brace must be in a line of its own.


	if(...){
		...
	} else {
		...
	}

 - Blocks with a single statement can either have the surrounding parenthesis or not. Whatever the case, it must be consistent throughout the entire document.

The following is allowed: 

	if (...)
		...

And so is: 

	if (...){
		...
	}

But not:

	if (...)
	{
		...
	}
