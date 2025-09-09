#!/bin/bash

echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃        .-----.-----.----.--|  |.--.--.           ┃"
echo "┃        |     |  -__|   _|  _  ||  |  |           ┃"
echo "┃        |__|__|_____|__| |_____||___  |           ┃"
echo "┃                                |_____|           ┃"
echo "┃ .--|  |.---.-.--.--.|  |_.----.|__|.-----.-----. ┃"
echo "┃ |  _  ||  _  |  |  ||   _|   _||  ||  _  |__ --| ┃"
echo "┃ |_____||___._|___  ||____|__|  |__||   __|_____| ┃"
echo "┃              |_____|               |__|          ┃"
echo "┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫"
echo "┃                   t̶e̶s̶t̶s̶?̶ s̶w̶e̶e̶t̶!̶                  ┃"
echo "┃                    test  suite                   ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"

# make sure everything we need is installed
# that is: playwright, which is our test runner
npm install --quiet
# and headless chrome to run tests in
npx playwright install chromium-headless-shell

# now run hugo server and trap exit to kill it when the test suite finishes
# we run hugo server so that the test suite is using a real webserver
# otherwise web browsers are super whiny about file:// urls
# we could just hugo build and then run a different web server
# but we've got hugo around, might as well use it
# We skip opengraph image building so that the test suite doesn't take ages
# and we render in memory so that we don't need to write to disk
# 61276 is the seating capacity of Anfield #YNWA
echo Building testing website in $TEMPD
HUGO_SKIP_OPENGRAPH=true hugo server --renderToMemory --port 61276 &
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# finally, run the tests
npx playwright test
