{% macro segmentation_age(column) %}
CASE
        WHEN {{column}} BETWEEN 0 AND 25 THEN 'below 25'
        WHEN {{column}} BETWEEN 26 AND 35 THEN '26-35'
        WHEN {{column}} BETWEEN 36 AND 50 THEN '36-50'
        WHEN {{column}} BETWEEN 51 AND 70 THEN '51-70'
        WHEN {{column}} > 70 THEN 'Senior'
        ELSE 'Unknown'
    END
{% endmacro %}
