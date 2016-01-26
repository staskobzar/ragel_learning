# Generate Ragel code and run tests
# 
all: test

test:
	ragel -R lib/*.rl
	bundle exec rspec

