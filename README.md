# Odinbook

_Odinbook_ is facebook clone built in rails, it's the final project from The Odin Project [Ruby on Rails course](http://www.theodinproject.com/ruby-on-rails/final-project)

[See it here!](https://aqueous-earth-6301.herokuapp.com/)


Example account:

- email: email1@example.com
- password:  qwerqwer

## Main features
1. [Account](#managing-account "Account")
1. [Content managing](#content-managing "Content managing")
1. [Friends](#making-friends "Friends")
1. [Looks and architecture](#looks-and-architecture "Looks and architecture")
1. [Additional information](#additional-information "Additional information")

## Managing account
##### Singing up
You can make a new account by providing your name, email, password and optionally your picture. After this, you will have an access to your profile where you can set additional information about you, set your gender and make your profile public or private if you don't want others to view your profile or your posts.

### Account pages
 * **Home**: Here is your feed, a place where are all of your and your friends posts. Page available only for you.
 * **Timeline**: List of all posts you have made and received. You can view other users timeline page if they are your friends or their profiles are public.
 * **People**: Place to manage your invitations and friends, it displays all of invitations received, sent and current friends. Page available only for you.
 * **Friends**: List of all of your friends. You can view other users friends page if they are your friends or their profiles are public.
 * **Profile**: Here there are all of information about you. You can view other users profile page if they are your friends or their profiles are public.
 * **Edit profile**: Here you can fill or change your profile, make description and set privacy. Page available only for you.
 * **All users**: List of all users on _Odinbook_.

## Content managing
##### Posts
When you want to create a post you can make it on your own timeline or yours friend. They will be displayed on your feed, and those made on someones timeline will have receivers name next to creators.

##### Comments
You can comment every post that belongs to you on one of your friends, how many times you want. Comments are paginated so just click show more if there is lots of them.

##### Likes
You can basically like everything, and if you ever make a mistake or change your mind you can remove your like. And if you want like it again. And repeat.

## Making friends
##### Invitations
If you want to make some friends you have to invite them first. Just visit their profile and click send request under their name. Or if profile is private find them in users list. You can remove invitations you sent, or accept those you received.

##### Managing your friends
After accepting invitation  by you or other user, you will be friends. You will have his posts on your timeline and he will have yours. But if you no longer want to be friend with someone fear not! You can remove a friend whenever you want on your people page.

## Looks and architecture
* **Style**: Most of styling and frontend of _Odinbook_ is made by myself, with a little help of bootstrap.
* **Tests**: _Odinbook_ is covered with more than 130 tests to make sure that all of main features are working and have no exploits. Or at least not so many.

## Additional information
_Odinbook_ is still in development phase, so the current version won't be deployed on production unless it will be stable.
