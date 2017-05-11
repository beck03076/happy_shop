#!/bin/bash
find . -name '*.rb'  ! -path "./vendor/*" ! -path "./config/*"  | xargs wc -l
