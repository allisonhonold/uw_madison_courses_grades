/*
Object:         Query
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Calculates the GPA from grade distribution.
                Only includes GPA-affecting grade categories.
                Returns the number and percent of non-GPA grades.
*/

SELECT  course_offering_uuid,
        section_number,

        (a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 + d_count * 1)
        / (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) AS section_gpa,

        (s_count + u_count + cr_count + n_count + p_count + i_count + nw_count + nr_count 
        + other_count) AS non_gpa_count,

        (s_count + u_count + cr_count + n_count + p_count + i_count + nw_count + nr_count 
        + other_count)/(s_count + u_count + cr_count + n_count + p_count + i_count + nw_count 
        + nr_count + other_count + a_count + ab_count + b_count + bc_count + c_count 
        + d_count + f_count) AS non_gpa_percent


FROM grade_distributions_casted
LIMIT 5;