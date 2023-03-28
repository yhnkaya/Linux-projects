#!/bin/bash

# Check if we are root privilage or not
if [[ ${UID} -ne 0 ]]
then
   echo "Please use this bash script with root privilage"
   exit 1
fi

# Define the backup directory
BACKUP_DIR="/mnt/backup"

# Define the directories to be backed up
DIRECTORIES=("/home/ec2-user/data")

# Get the hostname of the instance
HOSTNAME=$(hostname)

# Get the current date and time
DATE=$(date +%F-%H-%M)

# Print start status message.
echo "We will back up ${DIRECTORIES[@]} to under ${BACKUP_DIR}"
date
echo

# Create the backup directory if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
fi

# Iterate through the directories to be backed up
for DIR in "${DIRECTORIES[@]}"; do
    # Create the filename for the backup
    FILENAME="$BACKUP_DIR/$HOSTNAME-$DATE-$(basename $DIR).tgz"

    # Create the backup using tar
    tar -zcvf "$FILENAME" "$DIR"

    # Print the backup file name
    echo "Backup file: $FILENAME"
done

# Run "sed -i -e 's/\r$//' scriptname.sh" command before running script.

# Print end status message.
echo
echo "Congrulations! Your Backup is ready"
date


# DO NOT FORGET TO PASTE THIS INTO crontab -------->  */5 * * * * sudo /home/ec2-user/backup.sh