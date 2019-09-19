/*
Object:         Query
Author:         Aaron Chen
Script Date:    September 19, 2019
Description:    Returns the classes that are classified as STEM classes.
*/

CREATE MATERIALIZED VIEW stem_classes AS
    SELECT c.uuid, c.name,
            subj.code AS subject_code, subj.name AS subject_name,
            gdc.section_number,

            (gdc.a_count * 4 + gdc.ab_count * 3.5 + gdc.b_count * 3 + gdc.bc_count * 2.5 + gdc.c_count * 2 + gdc.d_count * 1)
                / (gdc.a_count + gdc.ab_count + gdc.b_count + gdc.bc_count + gdc.c_count + gdc.d_count + gdc.f_count) AS section_gpa,

            (gdc.s_count + gdc.u_count + gdc.cr_count + gdc.n_count + gdc.p_count + gdc.i_count + gdc.nw_count + gdc.nr_count 
                + gdc.other_count) AS non_gpa_count
    FROM subjects AS subj
    JOIN subject_memberships AS sm ON subj.code = sm.subject_code
    JOIN course_offerings AS c ON sm.course_offering_uuid = c.uuid
    JOIN grade_distributions_casted AS gdc ON c.uuid = gdc.course_offering_uuid

    WHERE ((gdc.a_count + gdc.ab_count + gdc.b_count + gdc.bc_count + gdc.c_count + gdc.d_count + gdc.f_count) != 0)
        AND (((a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 + d_count * 1)
            / (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count)) != 4)
        AND (subject_code IN ('108', '112', '120', '130', '132', '144', '146', '148', '188', '192', '200', '205', '206', '208', '210', '217', '220', '224', '266', '292', '320', '330', '346', '347', '348', '355', '360', '362', '370', '390', '396', '412', '416', '418', '420', '436', '480', '496', '503', '600', '604', '612', '616', '620', '621', '622', '623', '628', '632', '636', '640', '650', '676', '678', '681', '682', '684', '691', '692', '694', '695', '700', '702', '704', '708', '718', '724', '726', '728', '742', '745', '750', '754', '758', '762', '766', '810', '832', '840', '908', '932', '934', '936', '938', '939', '952', '960'))

    GROUP BY c.uuid, c.name, subj.name, subj.code, section_gpa, non_gpa_count, gdc.section_number;