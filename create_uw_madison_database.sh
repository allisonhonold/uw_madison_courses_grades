# make directory for data
mkdir data

# change into data directory
cd data/

# Install unzip if not on system, via homebrew
brew install unzip

# decompress the database files
# assumes that the zip is in the data folder
unzip uw-madison-courses.zip

# create new psql database
createdb uw_madison

# trasnfer SQLite database to uw_madison PostgreSQL database
pgloader database.sqlite postgresql:///uw_madison

# make directory for created data
mkdir write_data
