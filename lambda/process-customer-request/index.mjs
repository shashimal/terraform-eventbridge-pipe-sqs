export const handler = async (event) => {
    console.log("Enriched platinum customer events : %O", event);
    return event;
};
