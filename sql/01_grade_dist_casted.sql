/*
Object:         Materialized View
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Creates grade_distributions_casted with section number
                and all of the count columns as smallints. Adds column GPAs
*/

CREATE MATERIALIZED VIEW grade_distributions_casted AS
    SELECT course_offering_uuid, section_number, a_count, ab_count, b_count,
        bc_count, c_count, d_count, f_count, s_count, u_count, cr_count, n_count
        p_count, i_count, nw_count, nr_count, other_count,

        (a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 + d_count * 1)
                / (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) AS section_gpa
    
    FROM (SELECT course_offering_uuid,
                CAST(section_number AS SMALLINT),
                CAST(a_count AS SMALLINT),
                CAST(ab_count AS SMALLINT),
                CAST(b_count AS SMALLINT),
                CAST(bc_count AS SMALLINT),
                CAST(c_count AS SMALLINT),
                CAST(d_count AS SMALLINT),
                CAST(f_count AS SMALLINT),
                CAST(s_count AS SMALLINT),
                CAST(u_count AS SMALLINT),
                CAST(cr_count AS SMALLINT),
                CAST(n_count AS SMALLINT),
                CAST(p_count AS SMALLINT),
                CAST(i_count AS SMALLINT),
                CAST(nw_count AS SMALLINT),
                CAST(nr_count AS SMALLINT),
                CAST(other_count AS SMALLINT)
        FROM grade_distributions)
        AS casted

    WHERE (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) != 0
    ;