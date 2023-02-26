export const handler = async (event) => {
    console.log("Enriched platinum customer events : %O", event);

    if (event && event.length > 0) {
        event.forEach(eventObject => {
            console.log(eventObject)
        });
    }
    return event;
};
