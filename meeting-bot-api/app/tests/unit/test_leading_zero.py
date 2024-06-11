
import pytest
from app.utils.date import leading_zero


def test_leading_zero_should_return_number_with_leading_zero():
    assert leading_zero(1) == "01"


def test_leading_zero_should_return_number_without_leading_zero():
    assert leading_zero(10) == "10"
