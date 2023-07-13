terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_iot_thing_group" "office_group" {
  name = "office-group"
  properties {
    attribute_payload {
      attributes = {
        location = "NCS"
      }
    }
  }
}

resource "aws_iot_thing_group" "robots" {
  name              = "robots"
  parent_group_name = aws_iot_thing_group.office_group.name
}

resource "aws_iot_thing_group" "cctv-camera" {
  name              = "cctv-camera"
  parent_group_name = aws_iot_thing_group.office_group.name
}

resource "aws_iot_thing_type" "cleaning_robot" {
  name = "cleaning_robot"
  properties {
    searchable_attributes = ["Mopping"]
  }
}

resource "aws_iot_thing_type" "surveillance_robot" {
  name = "surveillance_robot"
  properties {
    searchable_attributes = ["Alarm"]
  }
}

resource "aws_iot_thing_type" "lift-camera" {
    name = "lift-camera"
    properties {
      searchable_attributes = ["24/7"]
    }
}