import os
import json
import datetime
from urllib2 import urlopen
from flask import Flask, request, render_template
from pymongo import MongoClient

#flask server
app = Flask(__name__)

#pymongo
db = MongoClient().webservice

@app.route('/hello', methods=['GET'])
def hello_world():
	""" hello world function """
	return "Hello world!"


@app.route('/', methods=['GET'])
def messages_service():
	""" render index """
	"""
		NOTA: nunca enviar un archivo estatico de esta forma.
		En cambio, utilizar un servidor web como Nginx.
	"""
	public_ip = str(json.load(urlopen('http://httpbin.org/ip'))['origin'])

	return render_template('index.html', ip_address=public_ip)


@app.route('/push_message', methods=['POST'])
def push_message():
	""" push message into the DB """
	username = request.form['username']
	content = request.form['message']

	message = {
		"timestamp" : str(datetime.datetime.now()),
		"username" : str(username),
		"content" : str(content)
	}

	db.messages.insert(message)

	return json.dumps({"status": "ok"})


@app.route('/messages', methods=['GET'])
def show_messages():
	""" dump messages stored in DB """
	response = []
	for message in db.messages.find():
		response.append({
			"username" : message['username'],
			"message" : message['content'],
			"timestamp" : message['timestamp']
		})

	return json.dumps(response)


@app.route('/messages/<username>', methods=['GET'])
def show_user_messages(username):
	""" show user's messages """
	response = []
	for message in db.messages.find({'username': str(username)}):
		response.append({
			"username" : message['username'],
			"message" : message['content'],
			"timestamp" : message['timestamp']
		})

	return json.dumps(response)


if __name__ == "__main__":
	""" run flask server """
	app.run(
		host='0.0.0.0',
		port=8080
	)
