{%- macro generate_schema_name(custom_schema_name=none, node=none) -%}
    
    {{- log("Generating schema name for node: " ~ node.name ~ " - " ~ custom_schema_name, info=False) -}}

    {{- log(target, info=False) -}}
    {%- set target_schema = target.schema -%}

    {%- if custom_schema_name is none -%}
        {{ target_schema }}
    {%- else -%}
        {{ custom_schema_name }}
    {%- endif -%}

{%- endmacro %}