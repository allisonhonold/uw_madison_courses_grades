/*
Object:         Materialized View
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Creates grade_distributions_casted with section number
                and all of the count columns as smallints.
*/

CREATE MATERIALIZED VIEW grade_distributions_casted AS
    SELECT  course_offering_uuid,
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
    FROM    grade_distributions;