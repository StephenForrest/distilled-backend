#!/bin/bash

rails s -p 3123
rookout --token $ROOKOUT_TOKEN --app $ROOKOUT_APP --debug --port 3123