<template>
  <div class="wadokaichin__vote-box col-6 text-right">
    <div id="rating" class="rating">
      <h6>平均：<%= @reactions.present? ? (@reactions.average(:rating)+3)/(@reactions.size+1) : 3.0 %></h6>
      <% if @reactions.where(remote_ip: request.remote_ip).present? %>
        <span class="badge badge-primary">投票済み</span>
      <% else %>
        <%= form_with url: quiz_wadokaichin_reactions_path do |f| %>
          <%= f.hidden_field :quiz_id, value: @quiz.id %>
          <%= f.hidden_field :remote_ip, value: request.remote_ip %>
          <% 5.times.each do |i| %>
            <label id="star-label-<%= i+1 %>" class="far fa-star fa-lg text-primary">
              <input
                type="radio"
                name="rating"
                class="d-none"
                value="<%= i+1 %>"
                v-model="star"
                v-on:click="rate"
              >
            </label>
          <% end %>
          <%= f.submit "投票する", class: "btn btn-outline-dark" %>
        <% end %>
      <% end %>
    </div>          
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      star: null
    }
  },
  methods: {
    rate(e) {
			x = e.currentTarget.value
			for (let i = 1; i < 6; i++) {
				// "far fa-star": blank, "fas fa-star": filled
				document.getElementById(`star-label-${i}`).classList.remove("far", "fas")
				if (i <= x) {
					document.getElementById(`star-label-${i}`).classList.add("fas")
				} else {
					document.getElementById(`star-label-${i}`).classList.add("far")
				}
			}
		}
  }
}
</script>
