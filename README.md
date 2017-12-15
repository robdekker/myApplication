# myApplication
Eindproject Native App Studio.

# IMPORTANT TO READ:
If you get an error in xcode like the following: "Apple Mach-O Linker Error"

Please follow the steps below to be able to run my application (i'm sorry it has to be this way).

1. Run `pod deintegrate` to remove any trace of Cocoapods from your project.
2. Run `pod install` to add it all back.

That's it, fixed.

## Screenshot 1: login screen
You need to fill in your correct email and password to be able to login.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image1.PNG)

## Screenshot 2: sign up screen
You need to fill in a correct email (checked by a RegEx) and a correct password (longer than 6 characters) to create a new account.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image2.PNG)

## Screenshot 3: sign up screen alert
You will receive a notification if something goes wrong.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image3.PNG)

## Screenshot 4: tableview of all Real Madrid players that come from the API
In the tableview the name of the player and his position are listed.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image4.PNG)

## Screenshot 5: online users
Clicking on the left bar button will perform a segue to a table view with all (online) users.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image5.PNG)

## Screenshot 6: player details
Clicking on a player from screenshot 4 will perform a segue to a table view with all details about the selected player.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image6.PNG)

## Screenshot 7: favorite players
You can add players to a table view of all favorite players. The player will be added to the realtime database on Firebase.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image7.PNG)

## Screenshot 8: delete favorite player
When deleting a player from the favorite players list, the player will also be deleted from the realtime database on Firebase.

![alt text](https://github.com/robdekker/myApplication/blob/master/doc/image8.PNG)


## My Better Code Hub score:

[![BCH compliance](https://bettercodehub.com/edge/badge/robdekker/myApplication?branch=master)](https://bettercodehub.com/)
