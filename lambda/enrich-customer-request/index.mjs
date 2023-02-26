export const handler = async (event) => {
    console.log("Filtered platinum customer events : %O", event);

    const enrichedEvents = []

    if (event && event.length > 0) {
        event.forEach(eventObj => {
            let updateEvent = {
                ...eventObj,
                ...{
                    agent_id: "0001",
                    agent_name : "Mark John",
                    agent_email: "markj@abc.com"
                }
            }
            enrichedEvents.push(updateEvent);
        });
    }
    return enrichedEvents;
};
