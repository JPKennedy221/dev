#!/bin/zsh
mix ecto.gen.migration create_teachers
mix ecto.gen.migration create_classes
mix ecto.gen.migration create_students
mix ecto.gen.migration create_units
mix ecto.gen.migration create_standards
mix ecto.gen.migration create_assessment_types
mix ecto.gen.migration create_assessments