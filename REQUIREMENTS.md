## Summary Look at Tables in Database
[Summary Look at Database](database_details.md)

## Entity Relationship Diagram for Database
![Entity Relationship Diagram for UW Madison Courses and Grades Database](ERD.png)

## Setting Up the Working Environment
Order of operations to generate the data used in our hypothesis tests:
1. Run bash script create_uw_madison_database.sh
2. In Terminal, open postgres with `psql uw_madison`
3. `\i create_grade_distributions_casted.sql`
4. `\i sorted_start_times_morning.sql`
5. `\i sorted_start_times_afternoon.sql`
6. `\i morning_classes_gpa.sql`
7. `\i afternoon_classes_gpa.sql`
8. `\i days_of_week_gpas.sql`
9. `\i stem_class_gpa.sql`
10. `\i non_stem_class_gpa.sql`