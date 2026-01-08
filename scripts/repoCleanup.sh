#!/bin/sh

aws ecr delete-repository --repository-name capstone-g3-gratitude/api-gateway --region eu-central-1   --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/client --region eu-central-1 --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/entries --region eu-central-1 --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/moods-api --region eu-central-1 --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/moods-service --region eu-central-1 --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/server --region eu-central-1 --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/stats-api --region eu-central-1 --force
aws ecr delete-repository --repository-name capstone-g3-gratitude/stats-service --region eu-central-1   --force

