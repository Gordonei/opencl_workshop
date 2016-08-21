# Workshop Preparation

This document details what I suggest you do in preparation for the OpenCL Workshop. The more time you spend on these activities, the more you'll get out of the workshop. However, diminishing returns do apply - I suggest a maximum of 4 hours.

We'll be working in an environment I have specially prepared for the course, however I have provided details below of the various software that we'll be using so that you can get more familiar with it.

## General Guidance
I find a good way to practice my knowledge is to use programming challenges. After working through the tutorials for a language, I suggest you test what you've learnt with some of the problems below.

* [Hacker Rank](https://www.hackerrank.com/) - wide variety of challenges, supporting many languages.
* [Project Euler](https://projecteuler.net/) - mathematically themed programming challenges with no sign-up required.

## Statically Typed Languages
OpenCL is essentially a subset of C, without dynamic memory allocation (on the plus side, no memory management!). So it'll be a good idea to refresh your knowledge of C-like languages. If you can remember without resorting to a reference how to declare variables, conditional statements (if,case) and loops (for,while), then you're fine. 

Otherwise, take at look at these:

* [C Variable Tutorial](http://www.cprogramming.com/tutorial/c/lesson1.html)  
* [C Conditional Tutorial](http://www.cprogramming.com/tutorial/c/lesson2.html)
* [C Loops Tutorial](http://www.cprogramming.com/tutorial/c/lesson3.html)

## Python
### Language Basics
There are a *lot* of Python tutorials online, for all ranges of ability. I've put a link to the official tutorial below, but feel to find one of your own. Note we will be using Python 3. As we will be using many libraries, I suggest brushing up on your Python object orientation.

* Most Linux distributions and Mac OSX come with Python installed, but just in case: [Python download](https://www.python.org/downloads/)
* [Official Python tutorial](https://docs.python.org/3/tutorial/introduction.html)
* [Object Orientation](http://www.python-course.eu/object_oriented_programming.php)

### Package Management
Python has an excellent package management system called pip. Here is [more details](https://packaging.python.org/installing/) on using it. Provided you have satisfied the various non-Python dependencies (see installation links below for more details), all you'll need to run is `pip3 install numpy matplotlib ipython jupyter` in your favourite shell to install all of the packages below. If you don't know what I mean by this, remain calm, just follow the links below.

## NumPy and Matplotlib
NumPy is a 3rd party, Open Source library for Python which along with SciPy provides support for a wide-array of scientific computing applications.  You might as well install SciPy, although we won't really be using it in this workshop.

* The best way to install Numpy is the full SciPy stack: [SciPy stack installation](http://scipy.org/install.html)
* [Numpy tutorial](https://docs.scipy.org/doc/numpy/user/quickstart.html)

Similarly, Matplotlib is a 3rd party library for graphical plotting.

* [Matplotlib installation](http://matplotlib.org/users/installing.html)
* [Matplotlib tutorial](http://matplotlib.org/users/pyplot_tutorial.html)

And if you're a (recovering) Matlab user: [NumPy for Matlab users](https://docs.scipy.org/doc/numpy-dev/user/numpy-for-matlab-users.html)

## IPython and Jupyter Notebooks
IPython is an *enhanced* shell for Python. In addition to nifty things like autocomplete and the Python debugger, it provides a wide array of "magic" functions which allow you to execute shell commands and profile arbitrary bits of Python code.

* [IPython installation](http://ipython.readthedocs.io/en/stable/install/index.html)
* [IPython tutorial](http://ipython.readthedocs.io/en/stable/interactive/tutorial.html)

Jupyter notebooks provide a programming environment inside your browser. It is probably the most commonly used programming environment in the burgeoning field of data science. You build up a 'notebook' of blocks of code and markdown text (it even supports TeX rendering). The Jupyter project used to be part of IPython, but is now language agnostic, so don't worry if some of the documentation refers to IPython notebooks.

* [Test drive Jupyter notebooks](https://try.jupyter.org/) - no installation required
* [Jupyter Notebook installation](http://jupyter.readthedocs.io/en/latest/projects/content-projects.html#installation)
* [Jupyter Notebook Quickstart Guide](https://jupyter-notebook-beginner-guide.readthedocs.io/en/latest/)

