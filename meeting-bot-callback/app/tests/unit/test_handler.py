import pytest
from app.main import handler


@pytest.fixture
def mock_logging(mocker):
    return mocker.patch("app.main.logger")


@pytest.fixture
def mocked_data():
    return {
        "action": "ping",
        "name": "Weekly Meeting",
        "time": "10:00",
        "description": "Discuss upcoming features"
    }


def test_handler_should_log_error_when_event_is_invalid(mock_logging):
    event = {
        "action": "test",
        "name": "Weekly Meeting",
        "time": "10:00",
        "description": "Discuss upcoming features"
    }

    handler(event, None)

    mock_logging.error.assert_called_once()


def test_handler_should_log_error_when_posting_to_discord_fails(mocker, mock_logging, mocked_data):
    mocker.patch("app.main.Discord").return_value.post.side_effect = Exception("Failed to post")

    handler(mocked_data, None)

    mock_logging.error.assert_called_once()


def test_handler_should_log_info_when_posting_to_discord_succeeds(mocker, mock_logging, mocked_data):
    mocker.patch("app.main.Discord").return_value.post.return_value = None
    handler(mocked_data, None)

    mock_logging.info.assert_called()
