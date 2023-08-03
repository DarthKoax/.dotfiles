  1 #!/usr/bin/python3
  2 import logging
  3 from flask import Flask, request
  4
  5 app = Flask(__name__)
  6
  7 log = logging.getLogger('werkzeug')
  8 log.setLevel(logging.ERROR)
  9
 10 @app.route('/log', methods=['POST'])
 11 def log():
 12     log_line = request.form.get('log_line', '')  # Default to '' if 'log_line' doesn't exist.
 13     client_ip = request.remote_addr
 14     print(f'{client_ip}: {log_line}')
 15     return '', 200
 16
 17 if __name__ == '__main__':
 18     app.run(host='0.0.0.0', port=5000)
