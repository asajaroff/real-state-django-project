PYTHON 	= python3
NAME		= real_state_project
SHELL 	:= /bin/bash
PROJECT	= ${NAME}
SITE		= src

.PHONY = help setup test run clean

# Defines the default target that `make` will to try to make, or in the case of a phony target, execute the specified commands
# This target is executed whenever we just type `make`
.DEFAULT_GOAL = help

# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "---------------HELP-----------------"
	@echo "To setup the project type make setup"
	@echo "To test the project type make test"
	@echo "To run the project type make run"
	@echo "To run migration make migrate"
	@echo "------------------------------------"

# This generates the desired project file structure
# ToDo: cmake is not able to enter the context of virtual env therefor is unable to install libraries within the environment
setup:
	@echo "Looking for a virtual environment"
	[ -e .venv ] || (echo "No virtual environment found, generating..." && ${PYTHON} -m venv .venv && source ${PWD}/.venv/bin/activate && pip install Django && django-admin startproject ${SITE}) && mkdir ${PWD}/${SITE}/{templates,static,media} && mv ${PWD}/${SITE} ${PWD}/${PROJECT}

# The ${} notation is specific to the make syntax and is very similar to bash's $() 
# This function uses pytest to test our source files
test:
	@echo "This functionality is missing"

migrate:
	${PYTHON} ${PWD}/manage.py migrate 

migrations:
	${PYTHON} ${PWD}/manage.py makemigrations

dev:
	${PYTHON} ${PWD}/manage.py runserver
	
run:
	gunicorn --chdir ${PWD} src.wsgi
	
heroku:
	heroku local

dbclean:
	rm ${PWD}/db.sqlite3

static:
	${PYTHON} ${PWD}/manage.py collectstatic

clean:
	@echo "Cleaning environment"
	rm -rf ${PWD}/.venv

activate:
	@echo "This functionality is missing"
