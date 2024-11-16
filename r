name: Test and Deploy

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Check out code
        uses: actions/checkout@v3
        
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      
      - name: Install dependencies
        run: |
          if [ -f requirements.txt ]; then 
            pip install -r requirements.txt
          else 
            echo "No requirements.txt found"
          fi
      
      - name: Run tests
        run: python -m unittest discover -s . -p "test*.py"

  deploy:
    runs-on: ubuntu-latest
    needs: test
    if: ${{ success() }}
    steps:
      - name: Check out code
        uses: actions/checkout@v3
        
      - name: Deploy application
        run: |
          echo 'Deploying...'
          # Add your actual deployment commands here
