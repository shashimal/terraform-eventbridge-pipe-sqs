export const handler = async (event) => {
    console.log("Filtered platinum customer events : %O", event);
    return event;
};
