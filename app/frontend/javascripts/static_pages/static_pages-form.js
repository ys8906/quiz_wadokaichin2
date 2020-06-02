export default {
  data() {
    return {
      email: null,
      isIncorrectEmail: false,
      name: null,
      title: null,
      content: null,
    }
  },
  watch: {
    email() {
      if (!this.email || this.email.match(/^[A-Za-z0-9]+[\w-]+@[\w.-]+\.\w{2,}$/)) {
        this.isIncorrectEmail = false;
      } else {
        this.isIncorrectEmail = true;
      }
    }
  },
}
