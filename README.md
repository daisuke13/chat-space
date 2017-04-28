# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#Name
Chatspace

# Description

Anyone can have a chat online by using Chatspace.

# Database

## Messages

|column  |   type   |                                  option|
|:----:  |:--------:|:--------------------------------------:|
|body    |   text   |                                        |
|image   |  string  |                                        |
|user_id | integer  |                              null:false|
|group_id| integer  |                              null:false|
|        |timestamps|                                        |
|        |          | add_reference :users, foreign_key: true|
|        |          |add_reference :groups, foreign_key: true|

## Users

|column                |   type   |                                               option|
|:--------------------:|:--------:|:---------------------------------------------------:|
|email                 |  string  |                                null: false, default:|
|incrypted_password    |  string  |                                null: false, default:|
|reset_password_token  |  string  |                                                     |
|reset_password_sent_at| datetime |                                                     |
|remember_created_at   | datetime |                                                     |
|sign_in_count         | integer  |                              default: 0, null: false|
|current_sign_in_at    | datetime |                                                     |
|last_sign_in_at       | datetime |                                                     |
|current_sign_in_ip    |  string  |                                                     |
|last_sign_in_ip       |  string  |                                                     |
|                      |timestamps|                                          null: false|
|                      |          |               add_index :users, :email, unique: true|
|                      |          |add_index :users, :reset_password_token, unique: true|
|name                  |  string  |                                          null: false|

## Groups

|column    |   type   |     option|
|:--------:|:--------:|:---------:|
|name      |  string  |null: false|
|          |timestamps|           |

## GroupUsers

|column    |   type   |option|
|:--------:|:--------:|:----:|
|user_id | integer  |        |
|group_id| integer  |        |
|        |timestamps|        |


# Asociation

## Message
  belongs_to :user
  belongs_to :group

## User
  has_many :messages
  has_many :groups, through: :group_users
  has_many :group_users

## Group
  has_many :users, through: :group_users
  has_many :messages
  has_many :group_users
