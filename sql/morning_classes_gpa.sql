/*
Object:         Query
Author:         Aaron Chen
Script Date:    September 19, 2019
Description:    Returns morning classes and their GPAs.
*/

CREATE MATERIALIZED VIEW morning_classes_gpas AS
    SELECT course_offering_uuid,
            section_number,

            (a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 + d_count * 1)
            / (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) AS section_gpa,

            (s_count + u_count + cr_count + n_count + p_count + i_count + nw_count + nr_count 
            + other_count) AS non_gpa_count,

            (s_count + u_count + cr_count + n_count + p_count + i_count + nw_count + nr_count 
            + other_count)/(s_count + u_count + cr_count + n_count + p_count + i_count + nw_count 
            + nr_count + other_count + a_count + ab_count + b_count + bc_count + c_count 
            + d_count + f_count) AS non_gpa_percent
    FROM all_morning_classes 
    JOIN grade_distributions_casted 
        ON all_morning_classes.uuid = grade_distributions_casted.course_offering_uuid
    JOIN course_offerings ON course_offerings.uuid = grade_distributions_casted.course_offering_uuid
    WHERE (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) != 0
        AND (a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 + d_count * 1)
            / (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) != 4;
