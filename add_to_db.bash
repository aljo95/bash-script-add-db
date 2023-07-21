#! /bin/bash

#Script to insert data from courses.csv and students.csv into students database

PSQL="psql -X --username=Passapa --dbname=students --no-align --tuples-only -c"

echo $($PSQL "TRUNCATE students, majors, courses, majors_courses")

cat courses.csv | while IFS="," read MAJOR COURSE
do
    echo $MAJOR
    if [[ $MAJOR != "major" ]]
    then
        #get major_id
        MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
        #if not found

        if [[ -z $MAJOR_ID ]] #Returns true if string is empty
        then
            #insert major
            INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
            if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
            then
                echo Inserted into majors, $MAJOR
            fi
            #get new major_id
            MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
        fi

        #get course_id
        COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
        #if not found

        if [[ -z $COURSE_ID ]] #checks if the query was empty so you can insert the course if needed
        then
            #insert course
            INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES('$COURSE')")
            if [[ $INSERT_COURSE_RESULT == 'INSERT 0 1' ]]
            then
                echo Inserted into courses, $COURSE
            fi
            #get new course_id
            COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
        fi

        #insert into majors_courses
        INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id, course_id) VALUES($MAJOR_ID, $COURSE_ID)")
        if [[ $INSERT_MAJORS_COURSES_RESULT == 'INSERT 0 1' ]]
        then
            echo Inserted into majors_courses, $MAJOR : $COURSE
        fi
    fi
done

#students.csv loop
cat students.csv | while IFS="," read FIRST LAST MAJOR GPA
do
    if [[ $FIRST != 'first_name' ]]
    then
        #get major_id (can not just add the major, need to get ID)
        MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")

        #if not found
        if [[ -z $MAJOR_ID ]]
        then
            #set to null
            MAJOR_ID=null
        fi

        echo hello $FIRST
        #insert student
        INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO students(first_name, last_name, major_id, gpa) VALUES('$FIRST', '$LAST', $MAJOR_ID, $GPA)")
        
        if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
        then
            echo Inserted into students, $FIRST $LAST
        fi
    fi
done