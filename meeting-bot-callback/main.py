from discordwebhook import Discord
from app.settings import settings
from app.custom_logging import logger
from app.schema import Event, Action


def handler(event: Event, context):
    try:
        event = Event(**event)
    except Exception as e:
        logger.error(f"Error parsing event: {e}")
        return

    if event.action == Action.PING:
        logger.info(f"Received {Action.PING.value} event")
        discord = Discord(url=settings.WEBHOOK_URL)

        content = f"@everyone There will be a meeting at **{event.time}**\n- Name: **{event.name}**\n- Description: {event.description}"

        try:
            discord.post(content=content)
            logger.info("Posted to discord")
        except Exception as e:
            logger.error(f"Error posting to discord: {e}")
    else:
        logger.warning(f"Unknown action {event.action}")
